from flask import Flask, request,jsonify

app=Flask(__name__)

@app.route('/api',methods=['GET'])
def api():
	d={}
	#simple query from flutter app to flask backend
	d['Query'] = str(request.args['Query'])
	return jsonify(d)


if __name__ == '__main__':
	app.run()

