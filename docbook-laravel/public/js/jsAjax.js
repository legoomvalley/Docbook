// registration form with ajax
$(function () {
    $("#patient-register-form").on('submit', function (e) {
        e.preventDefault();
        $('#patient-registration-btn').attr('disabled', 'disabled')
        $('#patient-registration-btn').text('please wait......')

        $.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            processData: false,
            beforeSend: function () {
                $(document).find('p.text-danger').text("");
            },
            success: function (data) {
                console.log(data)
                if (data.status == 0) {
                    $.each(data.error, function (prefix, val) {
                        $('p.' + prefix + '_error').text(val[0]);
                        $('#patient-registration-btn').text('submit')
                        $('#patient-registration-btn').removeAttr('disabled')
                    })
                } else {
                    $('#patient-registration-btn').attr('data-bs-dismiss', 'modal');
                    $('.success-registration').prepend(`
                    <div class="alert alert-success justify-content-between d-flex" role="alert">
                    `+ data.msg + `
                    <button type="button" class="btn-close mt-1" data-bs-dismiss="alert"
                        aria-label="Close"></button>
                </div>`)
                    $('#patient-registration-btn').attr('data-bs-dismiss', 'modal');
                    $('#patient-registration-btn').text('your account has been registered, please login')
                }
            }
        })

    })

    $("#doctor-comment-form").on('submit', function (e) {
        e.preventDefault();

        $('#doctor-comment-btn').attr('disabled', 'disabled')
        $('#doctor-comment-btn').text('sending comment......')

        $.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            processData: false,
            beforeSend: function () {
                $(document).find('p.text-danger').text("");
            },
            success: function (data) {
                if (data.status == 0) {
                    console.log(data.status)
                    $.each(data.error, function (prefix, val) {
                        $('#doctor-comment-btn').text('submit')
                        $('#doctor-comment-btn').removeAttr('disabled')
                        $('p.' + prefix + '_error').text(val[0]);
                    })
                } else {
                    $('#doctor-comment-btn').attr('data-bs-dismiss', 'modal');
                    $('.success-comment').prepend(`
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <div class="text-center"><i class="fa-sharp fa-solid fa-square-check me-1"></i>`+ data.msg + `
                    </div>

                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                `)
                    $('#doctor-comment-btn').attr('data-bs-dismiss', 'modal');
                    $('#doctor-comment-btn').text('your comment has been sent')
                    // $('p#errMsg').text(data.msg);
                }
            }
        })

    })

    $("#patient-appointment-form").on('submit', function (e) {
        e.preventDefault();

        $('#patient-appointment-btn').attr('disabled', 'disabled')
        $('#patient-appointment-btn').text('sending request......')


        $.ajax({
            url: $(this).attr('action'),
            method: $(this).attr('method'),
            data: new FormData(this),
            dataType: 'json',
            contentType: false,
            processData: false,
            beforeSend: function () {
                $(document).find('p.text-danger').text("");
            },
            success: function (data) {
                console.log(data)
                if (data.status == 0) {
                    $('#patient-appointment-btn').text('Book Here')
                    $('#patient-appointment-btn').removeAttr('disabled')
                    $.each(data.error, function (prefix, val) {
                        $('p.' + prefix + '_error').text(val[0]);
                    })
                } else {
                    $('.appointment-container').prepend(`
                    <div class="alert alert-dismissible alert-success col-11" role="alert">
                            ` + data.msg + `
                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                    </div>`)
                    $('#patient-appointment-btn').attr('data-bs-dismiss', 'modal');
                    $('#patient-appointment-btn').text('your request has been sent')
                }
            }
        })
    })

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    $(".displayActionModal").on("click", function () {
        const id = $(this).data('id')
        console.log(id)
        $("#action-form").on('submit', function (e) {
            e.preventDefault();


            $.ajax({
                url: $(this).attr('action'),
                method: $(this).attr('method'),
                data: { id: id },
                dataType: 'json',
                contentType: false,
                processData: false,
                beforeSend: function () {
                    $(document).find('p.text-danger').text("");
                },
                success: function (data) {
                    console.log(id)
                    console.log(data)
                    if (data.status == 0) {
                        $('#patient-appointment-btn').text('Book Here')
                        $('#patient-appointment-btn').removeAttr('disabled')
                        $.each(data.error, function (prefix, val) {
                            $('p.' + prefix + '_error').text(val[0]);
                        })
                    } else {
                        $('.appointment-container').prepend(`
                        <div class="alert alert-success" role="alert">
                                ` + data.msg + `
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                        </div>`)
                        $('#patient-appointment-btn').attr('data-bs-dismiss', 'modal');
                        $('#patient-appointment-btn').text('your request has been sent')
                    }
                }
            })
        })
    })
    $('.displayDetailsModal').on('click', function () {
        const id = $(this).data('id')
        console.log(id)
        $.ajax({
            url: 'http://docbook-laravel2.test/patient-record',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                $('.patient-modal-body #remark').text(data.remark);
                $('.patient-modal-body #status').text(data.status);
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #date').text(d + "/" + m + "/" + y + " | " + data.time);
                // $('.patient-modal-body #doctorName').text(data.first_name + " " + data.last_name);
            }
        })
    })
    $('.displayDetailsRequest').on('click', function () {
        const id = $(this).data('id')
        console.log(id)
        $.ajax({
            url: 'http://docbook-laravel2.test/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)

                $('.patient-modal-body #mobile_no').text(data.phone_no);
                $('.patient-modal-body #disease').text(data.disease);
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #date').text(d + "/" + m + "/" + y + " | " + data.time);
            }
        })
    })
    $('.displayDetailsCancel').on('click', function () {
        const id = $(this).data('id')
        $.ajax({
            url: 'http://docbook-laravel2.test/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                $('.patient-modal-body #mobile_no').text(data.phone_no);
                $('.patient-modal-body #disease').text(data.disease);
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #date').text(d + "/" + m + "/" + y + " | " + data.time);
                $('.patient-modal-body #approval').text(data.status);
            }
        })
    })
    $('.displayDetailsToday').on('click', function () {
        const id = $(this).data('id')
        $.ajax({
            url: 'http://docbook-laravel2.test/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                $('.patient-modal-body #mobile_no').text(data.phone_no);
                $('.patient-modal-body #disease').text(data.disease);
                $('.patient-modal-body #date').text(data.time);
            }
        })
    })
    $('.displayDetailsName').on('click', function () {
        const id = $(this).data('id')
        $.ajax({
            url: 'http://docbook-laravel2.test/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #mobile_no').text(data.phone_no);
                $('.patient-modal-body #disease').text(data.disease);
                $('.patient-modal-body #date').text(d + "/" + m + "/" + y + " | " + data.time);
                $('.patient-modal-body #status').text(data.status);
                $('.patient-modal-body #email').text(data.email);
            }
        })
    })
    $('.displayDetailsDate').on('click', function () {
        const id = $(this).data('id')
        $.ajax({
            url: 'http://docbook-laravel2.test/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #mobile_no').text(data.phone_no);
                $('.patient-modal-body #date').text(d + "/" + m + "/" + y + " | " + data.time);
                $('.patient-modal-body #email').text(data.email);
            }
        })
    })
    $('.displayDetailsTmpDoctor').on('click', function () {
        const id = $(this).data('id')
        $.ajax({
            url: 'http://docbook-laravel2.test/admin/dashboard',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                console.log(data)
                let date = new Date(Date.parse(data.date));
                let d = date.getDate();
                let m = date.getMonth() + 1;
                let y = date.getFullYear();
                $('.patient-modal-body #email').text(data.email);
                $('.patient-modal-body #mobile_no').text(data.mobile_number);
                $('.patient-modal-body #specialization').text(data.name);
            }
        })
    })
    $('.displayDetailsTmpComment').on('click', function () {
        const id = $(this).data('id')

        $.ajax({
            url: 'http://docbook-laravel2.test/admin/dashboard/comment',
            data: { id: id },
            method: 'post',
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: 'json',
            success: function (data) {
                $('.patient-modal-body #comment').text(data.comment);
            }
        })
    })
    $('.displayDetailsDoctor').on('click', function () {
        const id = $(this).data('id')
        console.log(id)

        $.ajax({
            url: 'http://docbook-laravel2.test/admin/dashboard/doctors',
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


})
