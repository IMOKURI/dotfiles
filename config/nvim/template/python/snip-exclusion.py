
import fcntl
import sys


def main():
    with open(__file__.replace('.py', '.lock'), 'w') as fp:
        try:
            fcntl.lockf(fp, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except IOError:
            sys.stderr.write('Program is already running.')
            sys.exit(1)
