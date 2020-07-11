! Driver    Julia Sales
! Navigator Anthony Overton
! Group 44-3, 10/17/2019
! Final Project - Type B
! main.F90

program main
    
    use euler
    implicit none

    integer :: i, size_N
    integer, dimension(4) :: N
    character(len=5):: run_num

    N = (/ 8, 16, 32, 64 /)
    size_N = 4

    do i = 1, size_N, 1

        if (N(i) < 10) then
            write(run_num, '(i1.0)')N(i)
        else
            write(run_num, '(i2.0)')N(i)
        end if

        call eulers_method(0., -2., 10., N(i), run_num)
        
    end do
    
end program main