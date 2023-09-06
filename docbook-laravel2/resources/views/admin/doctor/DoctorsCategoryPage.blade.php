<div id="doctorData" class="col-xl-12 col-md-12" style="padding: 0">
    <div
        class="mt-1 indexDashboard shadow rounded-3 px-1 mb-5 mx-auto table-responsive border-top border-5 border-primary">
        <h5 class="text-uppercase mt-3 ms-3 text-primary result">All Doctor</h5>
        @if(session()->has('success'))
        <div class="alert alert-success fade show col-12 col-md-8 col-lg-5 col-xxl-4 mx-auto d-flex justify-content-between"
            role="alert">
            <div>
                <i class="fa-sharp fa-solid fa-square-check me-1" style="margin-right: 10px"></i>
                <div class="d-inline text-start">
                    {{ session('success') }}
                </div>
            </div>
            <div>
                <button type="button" class="btn-close border-0 bg-transparent bg-opacity-10 mt-1"
                    data-bs-dismiss="alert" aria-label="Close" style="padding:0"><i
                        class="fa-solid fa-xmark"></i></button>
            </div>
        </div>
        @endif
        <table class="table table-borderless col-sm-12  allDoctorTable" id="doctorData">
            <thead>
                <tr>
                    <th scope="col" class="text-center"></th>
                    <th scope="col" class="text-center">full name</th>
                    <th scope="col" class="text-center">user name</th>
                    <th scope="col" class="text-center">detail</th>
                    <th scope="col" class="text-center">email</th>
                    <th scope="col" class="text-center">contact</th>
                    <th scope="col" class="text-center">specialization</th>
                </tr>
            </thead>
            <tbody>

                @foreach ($doctors as $item)
                <tr class="shadow-sm rounded">
                    <th scope="row" class="align-middle">{{ $loop->iteration }}</th>
                    <td class="align-middle text-center">{{ $item->name }}</td>
                    <td class="align-middle text-center">{{ $item->user_name }}</td>
                    <td class="align-middle text-center">
                        <form action="" method="post">
                            @csrf
                            <button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal2"
                                class="bg-transparent border border-0 align-middle displayDetailsDoctor2"
                                data-id='{{ $item->id }}'><i class="fa-sharp fa-solid fa-circle-info"></i>
                            </button>
                        </form>
                    </td>
                    <td class="align-middle text-center">{{ $item->email }}</td>
                    <td class="align-middle text-center">{{$item->mobile_number }}</td>
                    <td class="align-middle text-center specializationTd"></td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    {{-- endof indexDashboard --}}
    {{-- <div class="col-xl-9 col-md-12 d-flex justify-content-end" id="tblPagination" style="padding: 0">
        {{ $doctors->links() }}
    </div> --}}
</div>

<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content d-flex flex-row bg-transparent">
            <div style="backdrop-filter: blur(10px);background: rgba(78, 115, 223,0.3);  box-shadow: inset 0 0 0 200px rgba(255,255,255,0.2); border-radius: 8px;
" class="d-flex justify-self-center flex-column border border-0 col-sm-12 col-12">
                <div class=" border-dark-subtle border-2 border-bottom mx-2 d-flex
justify-content-between" style="height: 35px;">
                    <h1 class=" fs-6 mt-2" id="exampleModalLabel">Information</h1>
                    <button type="button" class="btn-close mt-2" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body patient-modal-body ms-2 mt-2">
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        email</h1>
                    <p id="email" class="justify-content-center d-flex fw-bolder text-body"></p>
                    <h1 class="fs-6 justify-content-center d-flex text-body-tertiary" id="exampleModalLabel">
                        mobile number
                    </h1>
                    <p id="mobile_no" class="justify-content-center d-flex fw-bolder text-body">
                    </p>
                </div>
                <div class="modal-footer border-dark-subtle border-2 mx-2">
                    <button type="button" class="btn btn-danger btn-sm" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
{{-- <script type="text/javascript" src="{{ asset('js/jsAjax.js') }}"></script> --}}
<script>
    $('.displayDetailsDoctor2').on('click', function () {
    const id = $(this).data('id')
    console.log(id)

    $.ajax({
        url: 'http://docbook-laravel2.test/admin/dashboard/allDoctor',
        data: { id: id },
        method: 'post',
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        dataType: 'json',
        success: function (data) {
            console.log(data)
         
            $('.patient-modal-body #email').text(data.email);
            $('.patient-modal-body #mobile_no').text(data.mobile_number);
        }
    })
})
</script>