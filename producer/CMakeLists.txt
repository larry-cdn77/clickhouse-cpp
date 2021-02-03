ADD_EXECUTABLE (producer
	main.cpp
)

TARGET_LINK_LIBRARIES (producer
        clickhouse-cpp-lib)
