from flask import Flask, render_template, request
from flask_mysqldb import MySQL
app = Flask(__name__)


app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'emerge'
app.config['MYSQL_DB'] = 'emerge'

mysql = MySQL(app)


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == "POST":
        details = request.form
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO Municipality(municipality_id, jurisdiction_radius, name, state, UID) VALUES (%int, %decimal, %varchar, %char, %varchar)",  (12345, 4.23, 'POPO', 'NJ', 'qwer'))
        mysql.connection.commit()
        cur.close()
        return 'success'
    return render_template('index.html')


if __name__ == '__main__':
    app.run()
