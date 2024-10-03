program time_loop
    implicit none
    integer :: start_clock, end_clock, clock_rate
    real :: elapsed_time, j
    integer :: i
    integer :: file_unit

    ! Assign a unit number for the file (unit numbers are unique identifiers for file I/O)
    file_unit = 10

    ! Open the file "timing_results.txt" for writing (unit=10)
    open(unit=file_unit, file="timing_results.txt", status="unknown")

    ! Get the clock rate (number of ticks per second)
    call SYSTEM_CLOCK(count_rate=clock_rate)

    ! Get the starting clock count
    call SYSTEM_CLOCK(count=start_clock)

    ! Your loop here
    do i = 1, 10000000
        ! Simulate work
        j = i * 2
    end do

    ! Get the ending clock count
    call SYSTEM_CLOCK(count=end_clock)

    ! Calculate the elapsed time in seconds
    elapsed_time = real(end_clock - start_clock) / real(clock_rate)

    ! Write the result to the file
    write(file_unit, *) 'Time taken by the loop: ', elapsed_time, ' seconds'

    ! Close the file
    close(file_unit)
end program time_loop
