--include('shared.lua')

require("mysqloo")

db = mysqloo.connect( "localhost", "root", "", "rp")
db:connect()
 
function db:onConnectionFailed( err )
 
    print( "Connection to database failed!" )
    print( "Error:", err )
 
end

function Query( str )
	local d = db:query(str)
	d:start()
	function d:onSuccess(data)
		print('Success')
	end
	function d:onError(err)	
		print(err)
	end
end

function GetDataQuery( str, callback )
	local d = db:query(str)
	d:start()
	function d:onSuccess(data)
		callback(data)
	end
end

