
import argparse


def main():
    args = get_args()
    print(args)


def get_args():
    parser = argparse.ArgumentParser(description="""
    This is great script!
    """)

    parser.add_argument('--single-args', nargs=1, required=True, help='Help message.')
    parser.add_argument('--multiple-args', nargs='+', required=True, help='Help message.')
    parser.add_argument('--optional-single-args', nargs='?', default='default value', help='Help message.')
    parser.add_argument('--optional-multiple-args', nargs='*', default=[1, 2, 3], help='Help message.')
    parser.add_argument('--enable-flag', action='store_true', help='Help message.')

    return parser.parse_args()
