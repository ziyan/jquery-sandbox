import re
import time

def yesno(condition, true_value, false_value):
    if condition:
        return true_value
    return false_value

def lines(text):
    text = re.sub(r'\r\n|\r|\n', '\n', text)
    ps = re.split('\n{2,}', text.strip())
    if ps == ['']:
        ps = []
    ps = [re.split('\n', p) for p in ps]
    return ps

def timestamp(datetime):
    return long(time.mktime(datetime.timetuple()))
