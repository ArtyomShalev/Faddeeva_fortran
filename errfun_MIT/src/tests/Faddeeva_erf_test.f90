program Faddeeva_erf_test
    use faddeeva_fortran_interface, only: Faddeeva_erf, find_relerr, dp
    implicit none
!    integer, parameter :: dp=kind(0.d0)
!!    complex(dp) :: test_args(2), ref_values(2), res(2)
    complex(dp), allocatable :: res(:)
    real(dp), allocatable :: re_err(:), im_err(:)
    real(dp) :: relerr, errmax
    integer :: i, num_args
!
    include '../../../reference_data.f90'
!
!!    test_args = (/ cmplx(1_dp, 2_dp, dp), cmplx(-1_dp, 2_dp, dp) /)
!!    ref_values = (/ cmplx(-0.5366435657785650339917955593141927494421_dp, -5.049143703447034669543036958614140565553_dp, dp), &
!!            cmplx(0.5366435657785650339917955593141927494421_dp, -5.049143703447034669543036958614140565553_dp, dp) /)
   !TODO num_args = size(Faddeeva_w_args)
    relerr = 0.0_dp
    errmax = 0
    do i = 1, num_args
        res(i) = Faddeeva_erf(Faddeeva_erf_args(i), relerr)
!!        re_err(i) = abs(real(res(i)) - real(ref_values(i)))/abs(real(ref_values(i)))
!!        im_err(i) = abs(aimag(res(i)) - aimag(ref_values(i)))/abs(aimag(ref_values(i)))
        re_err(i) = find_relerr(real(res(i)), real(Faddeeva_w_wolfram_refs(i)))
        im_err(i) = find_relerr(aimag(res(i)), aimag(Faddeeva_w_wolfram_refs(i)))
!
        if (re_err(i) > errmax) errmax = re_err(i)
        if (im_err(i) > errmax) errmax = im_err(i)
!
        if (errmax > 1e-13) then
            print *, "FAILURE -- relative error", errmax, "is too large!"
            stop 1
        end if
    end do

end program Faddeeva_erf_test