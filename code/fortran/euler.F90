! Driver    Julia Sales
! Navigator Anthony Overton
! Group 44-3, 10/17/2019
! Final Project - Type B
! euler.F90

module euler

implicit none
    contains

    ! dydt()
    ! Purpose: Given y & t, it calculates the value of dy/dt
    real function dydt(t,y)
        implicit none
        real :: t, y, i, numerator, denominator

        numerator = 2*t
        denominator = y*(1+(t**2))
        i = numerator/denominator
        dydt = i

    end function dydt

    ! eulers_method()
    ! Purpose:  Solves the equation dy/dt where y(0)= -2 with the Euler’s method.
    ! At each step, the subroutine prints t and the numerical solution into a separate file, named as file_name.
    subroutine eulers_method(t_0, y_0, t_f, N, file_name)

        real :: t_0, y_0, t_f, t_n, t_n_prev, y_n, delta
        integer :: small_n, N
        character(len = 5) :: file_name
        character(len = 32) :: ofile

        ofile = 'output_'//trim(file_name)//'.dat'
        open(unit=20,file=ofile,status='unknown')

        do small_n = 0, N, 1
            delta = t_f/N
            t_n = small_n*(delta)

            ! Find y
            if (small_n == 0) then
                y_n = y_0
            else if (small_n == 1) then
                !fCall = dydt(t_0, y_0)
                y_n = y_0 + (delta*(dydt(t_0, y_0)))
            else
                t_n_prev = (small_n - 1) *(delta)
                !fCall = dydt(t_n_prev,y_n)
                y_n = y_n + (delta*(dydt(t_n_prev,y_n)))
            end if
            !print*, 'fCall: ', fCall
        
            ! Write to file
            write(20,920) small_n, t_n, y_n
        end do

        ! Output Format Specifiers
        920 format(1x, i5, f16.8, 1x, f16.12)
        close(20)

    end subroutine eulers_method

end module euler
