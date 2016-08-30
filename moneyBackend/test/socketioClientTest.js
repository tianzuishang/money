var socket = require('socket.io-client')('http://localhost:3001');

socket.on('connect', function(data){
    console.log('connect');
    socket.on('authorize', function(data){
        console.log('authorize event');

        socket.emit('authorize', {
            token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoid2FuZ2hhbiJ9.QdPtpEVXADNwCkZPHCbE6WmZci83Zea-R9ERinf41sE'
        });

        socket.on('authorized', function(data){
            console.log('authorized event ' + JSON.stringify(data));
            if (data.code === 1005) {
                console.log('authorized ok');
            }else{
                console.log('authorized failed');
            }
            console.log('emit data');
            socket.emit('data', {data:'testtest'});
            socket.on('data', function(data){
                console.log(JSON.stringify(data));
            });
        });

    });
});


socket.on('disconnect', function(){
    console.log('disconnect');
});
