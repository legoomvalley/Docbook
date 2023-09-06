<script>
    $(document).ready(function(){
            @foreach($specializations as $item)
        $('li#spec{{ $item->id }}').click(function(){
            var spec = $('#spec{{ $item->id }}').val();
            console.log(spec)
            $.ajax({
                type:'post',
                dataType:'html',
                url:'{{route('admin.getDoctorByCategory') }}',
                data:{id:spec},
                success:function(data){

                    $('#doctorData').html(data)
                    $('.result').text($('li#spec{{ $item->id }}').text())
                    $('.specializationTd').text($('li#spec{{ $item->id }}').text())
                }
            })
        })
        
        @endforeach

        $(document).on('click', '.pagination a', function(event){
            event.preventDefault();
            let page = $(this).attr('href').split('page=')[1];
            fetch_data(page)
        })
        function fetch_data(page){
            $.ajax({
                url:"http://docbook-laravel.test/admin/dashboard/fetchAllDoctorCategory?page="+page,
                success:function(data){
                    $('#doctorData').html(data)
    
                    // $('.result').text('#spec{{ $item->id }}').text())
    
                }
            })
        }
        
        $('.result').on('click', function () {
        const id = $(this).data('id')
        console.log("muazz")
        $.ajax({
            url: 'http://docbook-laravel.test/admin/dashboard/allDoctor',
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
                $('.patient-modal-body #location').text(data.location);
            }
        })
    })
        
    //             $('#doctorData').html(data)
    //         }
    //     })
    // }
});
</script>