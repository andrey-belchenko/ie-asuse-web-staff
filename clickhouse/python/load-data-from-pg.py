from datetime import datetime, time
import psycopg2
from clickhouse_driver import Client

pg_conn = psycopg2.connect(
    dbname="asuse",
    user="asuse",
    password="kl0pik",
    host="asuse-ai-dev.infoenergo.loc",
    port="5432",
)

pg_cursor = pg_conn.cursor()

ch_client = Client("localhost")
ch_client.execute("TRUNCATE TABLE msr_fin")

pg_cursor.execute("DECLARE my_cursor CURSOR FOR SELECT * FROM report_dm.msr_фин")

chunk_size = 100000
portion = 0
while True:
    pg_cursor.execute("FETCH FORWARD %s FROM my_cursor", (chunk_size,))
    pg_data = pg_cursor.fetchall()
    if not pg_data:
        break
    portion += 1
    # print(pg_data)
    print("portion:", portion,  datetime.now().time())
    while True:
        try:
            ch_client.execute("INSERT INTO msr_fin FORMAT TabSeparated", pg_data, types_check=True)
            break
        except Exception as e:
            print("Error occurred:", e)
            print("Waiting for 30 seconds before retrying...")
            time.sleep(30)