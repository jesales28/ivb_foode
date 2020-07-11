!test.f90

module demo

implicit none
    contains
    
    ! dydt()
    ! Purpose: Given y & t, it calculates the value of dy/dt
    real function dydt(t,y)

        real, intent(in) :: y, t
        real :: i, numerator, denominator

        numerator = 2*t
        denominator = y*(1+(t**2))
        i = numerator/denominator
        dydt = i

    end function dydt

    ! eulers_method()
    ! Purpose:  Solves the equation dy/dt where y(0)= -2 with the Euler’s method.
    ! At each step, the subroutine prints t and the numerical solution into a separate file, named as file_name.
    subroutine eulers_method(t_0, y_0, t_f, N, file_name)

        real, intent(in) :: y_0, t_0
        real :: t_n, t_n_prev, y_n, delta, fCall
        integer :: small_n, t_f, N
        character :: file_name
        character(len = 32) :: ofile

        ofile = 'output_'//trim(file_name)//'.dat'
        open(unit=20,file=ofile,status='unknown')

        do small_n = 0, t_f, 1
            print*, 'small_n: ', small_n
            delta = t_f/N
            t_n = small_n*(delta)

            ! Find y
            if (small_n == 0) then
                y_n = y_0
            else if (small_n == 1) then
                fCall = dydt(t_0, y_0)
                y_n = y_0 + (delta*fCall)
            else
                t_n_prev = (small_n - 1) *(delta)
                fCall = dydt(t_n_prev,y_n)
                y_n = y_n + (delta*fCall)
            end if
            
            print*, 'y_n: ', y_n
            ! Write to file
            write(20,920) small_n, t_n, y_n
        end do

        ! Output Format Specifiers
        920 format(1x, i5, f16.8, 1x, f16.12)
        close(20)
        
    end subroutine eulers_method

end module demo
!---------------------------------------------------------

program test
use demo
implicit none
    real :: y, function_call
    integer :: t, N
    character(len=5):: run_num
    N = 8
    write(run_num, '(i1.0)')N
    print*,'run_num = ', run_num

    !function_call = dydt(t, y)
    call eulers_method(0., -2., 10, N, run_num)

end program test
