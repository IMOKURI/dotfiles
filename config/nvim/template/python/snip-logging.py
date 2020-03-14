
import logging
import sys

# DEBUG, INFO, WARN, ERROR
LOG_LEVEL = 'INFO'


def main():
    logger = set_logger()

    logger.info('Started...')

    logger.info('Finished...')


def set_logger():
    try:
        logging.basicConfig(
            filename=__file__.replace('.py', '.log'),
            level=logging.getLevelName(LOG_LEVEL),
            format='%(asctime)s [%(levelname)s] [%(module)s] %(message)s'
        )
    except ValueError as err:
        sys.stderr.write('{}'.format(err))
        sys.exit(1)

    return logging.getLogger(__name__)
