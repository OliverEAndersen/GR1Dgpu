!-*-f90-*-
program GR1D	
    	  
  use GR1D_module
  implicit none
  integer :: start_clock, end_clock, clock_rate
  real :: elapsed_time

  !Welcome to GR1D
  write(*,*) "#################################################"
  write(*,*) "#################################################"
  write(*,*) "########### GR1D SPHERICAL HYDRO v2 #############"
  write(*,*) "######### Now with Neutrino Transport ###########"
  write(*,*) "################# Nov ??, 2014 ##################"
  write(*,*) "#################################################"

  ! Call problem setup and allocate/initialize variables 
  call start
  write(*,*) "Done with initial data :-)"

  write(*,*) "Begin time integration loop:"
  IntegrationLoop: do 

     call SetTimeStep

     call handle_output

!!   Integrate
     call SYSTEM_CLOCK(count_rate=clock_rate)
     call SYSTEM_CLOCK(count=start_clock)
     call Step(dt)
     call SYSTEM_CLOCK(count=end_clock)
     elapsed_time = real(end_clock - start_clock) / real(clock_rate)
     !print*, 'Time taken by the loop: ', elapsed_time, start_clock, end_clock, ' seconds'

     call postStep_analysis
     
  enddo IntegrationLoop
      
  write(*,*) "Shutting down!"
  write(*,*) " "

end program GR1D
