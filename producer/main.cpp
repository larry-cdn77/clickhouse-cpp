#include <iostream>
#include <cassert>
#include <csignal>
#include <string>
#include <clickhouse/client.h>

bool sigint = false;

void signalHandler(int sig)
{
    (void)sig;
    std::cout << "signal" << std::endl;
    sigint = true;
}

int main(int argc, char * argv[])
{
    if (argc != 5) {
        std::cout << "usage: producer HOST_IP TABLE START NUM_ROWS" << std::endl;
        return 1;
    }
    std::string host_ip = argv[1];
    std::string table = std::string(argv[2]);
    unsigned start = std::stoi(argv[3]);
    unsigned num_rows = std::stoi(argv[4]);
    try {
        clickhouse::Client client(clickhouse::ClientOptions().
            SetHost(host_ip).
            SetPingBeforeQuery(true).
            SetCompressionMethod(clickhouse::CompressionMethod::LZ4));
        std::signal(SIGINT, signalHandler);
        clickhouse::Block block;
        auto time = std::make_shared<clickhouse::ColumnDateTime>();
        auto id = std::make_shared<clickhouse::ColumnUInt32>();
        for (unsigned r = 0; r < num_rows; r++) {
            if (sigint) {
                break;
            }
            time->Append(static_cast<std::time_t>(1611161143 + (start + r))); // 1611161143 is 20 Jan 2021 17:45:43
            id->Append(start + r);
        }
        block.AppendColumn("time", time);
        block.AppendColumn("id", id);
        client.Insert(table, block);
    }
    catch (const clickhouse::ServerException & e) {
        std::cout << "server exception: " << e.GetCode() << std::endl;
    }
    catch (const std::exception & e) {
        std::cout << "std exception: " << e.what() << std::endl;
        return 1;
    }
    std::cout << "generated " << num_rows << " rows" << std::endl;
    return 0;
}
