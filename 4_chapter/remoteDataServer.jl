using LibPQ, DataFrames, CSV

host     = "remoteHost"
dbname   = "db1"
user     = "username"
password = "userPwd"
port     = "1111"

conStr= "host=" *host *
        " port=" *port *
        " dbname=" *dbname *
        " user=" *user *
        " password=" *password
conn = LibPQ.Connection(conStr)

df = DataFrame(execute(conn, "SELECT * FROM S1.T1"))
close(conn)

CSV.write("example.csv", df);