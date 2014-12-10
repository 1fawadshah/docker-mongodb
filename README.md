- Setup:
========
    * Create Data Directory (on Docker Host):
    # mkdir -p /opt/mongodb0/data/db /opt/mongodb1/data/db /opt/mongodb2/data/db

    * Build Docker Image (on Docker Host):
        # docker build -t deployment/mongo .

    * Run Docker Container (on Docker Host):
        # docker run --name mongo0 -d -v /opt/mongodb0/data/db:/data/db -p 27017:27017 -p 28017:28017 -t deployment/mongo
        # docker run --name mongo1 -d -v /opt/mongodb1/data/db:/data/db -p 27117:27017 -p 28117:28017 -t deployment/mongo
        # docker run --name mongo2 -d -v /opt/mongodb2/data/db:/data/db -p 27217:27017 -p 28217:28017 -t deployment/mongo

    * Setup Replication Set (on Mongo Instance):
        Connect with any of the mongo instance which you want to be running as PRIMARY.
        Example (in case of 'mongo0'):
        # mongo 192.168.0.1:27017
            > rs.initiate({_id:'replicaset01', members:[{_id:0, host:'[mongo0-private-ip]:27017'}]})
            > rs.add("[mongo1-private-ip]:27017")
            > rs.add("[mongo2-private-ip]:27017")
            > rs.status()

                - 192.168.0.1 is Docker host IP on eth interface
                - mongo[0/1/2]-private-ip; check IP address with command 'docker inspect'
                    Ex: # docker inspect mongo0
                    
    * To Remove Replication Information (on all Mongo Instance):
        > use local
        > db.dropDatabase()
                    
    Mongodb data and logs are persistant, in case docker container goes down db and logs will be available in /opt/mongodb[0/1/2]/data/db directory on Docker host.
