#!/usr/bin/python

import MySQLdb
import random
import time

while True:
  try:
    dbrw = MySQLdb.connect(host="127.0.0.1", port=3307, user="app", passwd="app", db="test", connect_timeout=1)
    rwcursor = dbrw.cursor()
    try:
      rwcursor.execute("INSERT INTO user (name) VALUES ('%s')" % random.random())
      dbrw.commit()
      print "Write: Success"
    except:
      print "Write:Database is read only"
  except:
      print "Write: Database not accessible"
  db = MySQLdb.connect(host="localhost", user="app", passwd="app", db="test")
  dbcursor = db.cursor()
  dbcursor.execute("SELECT COUNT(*) FROM user")
  data = dbcursor.fetchone()
  print "Read: %s" % data
  time.sleep(0.5)
