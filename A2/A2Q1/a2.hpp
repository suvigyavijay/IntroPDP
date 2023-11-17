/*  SUVIGYA
 *  VIJAY
 *  suvigyav
 */

#ifndef A2_HPP
#define A2_HPP

#include <vector>
#include <mpi.h>

// this function returns the rank to which the value should be sent
int get_send_rank(int value, int size) {
    int send_rank;
    send_rank = (value + (size - 1)) / 2;
    return send_rank;
}

void isort(std::vector<short int>& Xi, MPI_Comm comm) {
    int size, rank;

    MPI_Comm_size(comm, &size);
    MPI_Comm_rank(comm, &rank);

    int loc_n = Xi.size();

    // loop over Xi
    std::vector<MPI_Request> requests(loc_n);
    for (int i = 0; i < loc_n; i++) {
        int send_rank = get_send_rank(Xi[i], size);

        // non-blocking send the value to send_rank
        MPI_Isend(&Xi[i], 1, MPI_SHORT, send_rank, 0, comm, &requests[i]);

        // print the sent value with rank
        printf("rank %d sent %d to rank %d\n", rank, Xi[i], send_rank);
    }

    // send STOP tag to all ranks
    for (int i = 0; i < size; i++) {
        MPI_Request request;
        MPI_Isend(nullptr, 0, MPI_SHORT, i, 0, comm, &request);
        requests.push_back(request);
    }

    // receive possible values into buffers
    short int val1 = (2 * rank) - (size - 1);
    short int val2 = val1 + 1;
    std::vector<short int> vec_val1;
    std::vector<short int> vec_val2;

    // receive messages until STOP tag is received from all sources
    int receivedStopTags = 0;
    while (receivedStopTags < size) {
        MPI_Status status;
        MPI_Probe(MPI_ANY_SOURCE, 0, comm, &status);

        // if a message is found, get the count and receive the data
        int count;
        if (MPI_Get_count(&status, MPI_SHORT, &count) == MPI_SUCCESS) {
            // create buffer to receive the value
            std::vector<short int> recv_val(count);

            // perform the blocking receive into the buffer
            MPI_Recv(recv_val.data(), count, MPI_SHORT, status.MPI_SOURCE, 0, comm, MPI_STATUS_IGNORE);

            // check for STOP tag
            if (count == 0) {
                receivedStopTags++;
            } else {
                // add received values to vec_val1 or vec_val2
                for (int i = 0; i < recv_val.size(); i++) {
                    if (recv_val[i] == val1) {
                        vec_val1.push_back(recv_val[i]);
                    } else if (recv_val[i] == val2) {
                        vec_val2.push_back(recv_val[i]);
                    } else {
                        printf("ERROR: received value %d is not %d or %d\n", recv_val[i], val1, val2);
                    }
                }
                printf("\n");
            }
        }
    }

    // wait for all non-blocking sends to complete
    MPI_Waitall(requests.size(), requests.data(), MPI_STATUS_IGNORE);

    // resize and overwrite Xi with concat of vec_val1 and vec_val2
    Xi.resize(vec_val1.size() + vec_val2.size());
    std::copy(vec_val1.begin(), vec_val1.end(), Xi.begin());
    std::copy(vec_val2.begin(), vec_val2.end(), Xi.begin() + vec_val1.size());

} // isort

#endif // A2_HPP
