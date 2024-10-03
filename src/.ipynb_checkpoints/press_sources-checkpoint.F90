!-*-f90-*-
subroutine press_sources

  use GR1D_module
  implicit none

  integer i

  !do nothing in planar geometry
  if(geometry.eq.1) return
  
  if (GR) then 
     do i=2,n1
        presssource(i,2) = 2.0d0*alp(i)*press(i)/X(i)/x1(i)
        if(do_rotation) then
           presssource(i,2) = presssource(i,2) &
                + twothirds * alp(i) * &
                (rho(i) + rho(i)*eps(i) + press(i)) &
                * W(i)*W(i)*vphi(i)**2 / (X(i) * x1(i))

           !not really a pressure source :| sorry...
           presssource(i,5) = (rho(i) + rho(i)*eps(i) + press(i)) * &
                W(i)*W(i)*alp(i)*v(i)*vphi(i)*X(i) * &
                (4.0d0*pi*x1(i)**2 * press(i) + mgrav(i) / x1(i))

        endif
     enddo

  else
    !$omp target teams distribute parallel do &
    !$omp map(to: press, x1, sqrt_gamma, n1) &     
    !$omp map(tofrom: presssource) 
     do i = 2,n1
        presssource(i,2) = 2.0d0*press(i)/x1(i) * sqrt_gamma(i)
     enddo
     !$omp end target teams distribute parallel do

     if(do_rotation) then
        !$omp target teams distribute parallel do &
        !$omp map(to: rho, vphi1, sqrt_gamma, x1) &     
        !$omp map(tofrom: presssource) 
        do i = 2,n1
           presssource(i,2) = presssource(i,2) &
                + twothirds*rho(i)*vphi1(i)**2 / x1(i) * sqrt_gamma(i)                
        enddo
        !$omp end target teams distribute parallel do

     endif

  endif

end subroutine press_sources
