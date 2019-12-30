import datetime

def log(token, message):
    time = datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S")
    line = f'{token[:2]}...{token[-3:]} | {time} | {message}\n'
    with open('log','a') as f:
        f.write(line)

