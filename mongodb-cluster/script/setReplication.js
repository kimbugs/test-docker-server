config = {
    _id: "my-mongo",
    members: [
        {_id:0, host: "mongo-1:27017"},
        {_id:1, host: "mongo-2:27017"},
        {_id:2, host: "mongo-3:27017"},
    ]
}

rs.initiate(config);
rs.conf();