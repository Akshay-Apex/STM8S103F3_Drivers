import re
import sys
from pathlib import Path

FLASH_SIZE = 8192  # STM8S103 flash in bytes
RAM_SIZE = 1024    # STM8S103 RAM in bytes

FLASH_SECTIONS = {
    'HOME',
    'GSINIT',
    'GSFINAL',
    'CODE',
    'CONST',
    'INITIALIZER',
    'INITIALIZED'
}

RAM_SECTIONS = {
    'DATA',
    'BSS',
    'DABS',
    'SSEG'
}


def parse_map_file(map_path):
    flash_total = 0
    ram_total = 0

    section_sizes = {}

    pattern = re.compile(
        r'^([A-Za-z._]+)\s+[0-9A-Fa-f]+\s+([0-9A-Fa-f]+)'
    )

    with open(map_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            match = pattern.match(line.strip())

            if not match:
                continue

            section = match.group(1).strip('.')
            size_hex = match.group(2)

            try:
                size = int(size_hex, 16)
            except ValueError:
                continue

            section_sizes[section] = size

            if section in FLASH_SECTIONS:
                flash_total += size

            if section in RAM_SECTIONS:
                ram_total += size

    return flash_total, ram_total, section_sizes


def main():
    if len(sys.argv) < 2:
        print('Usage: python stm8_size.py <map_file>')
        return

    map_file = Path(sys.argv[1])

    if not map_file.exists():
        print(f'Error: File not found: {map_file}')
        return

    flash_total, ram_total, section_sizes = parse_map_file(map_file)

    flash_remaining = FLASH_SIZE - flash_total
    ram_remaining = RAM_SIZE - ram_total

    flash_percent = (flash_total / FLASH_SIZE) * 100
    ram_percent = (ram_total / RAM_SIZE) * 100

    print('========== STM8 MEMORY USAGE ==========' )
    print(f'File             : {map_file.name}')
    print(f'Flash Used       : {flash_total} bytes')
    print(f'Flash Remaining  : {flash_remaining} bytes')
    print(f'Flash Usage      : {flash_percent:.2f}%')
    print()
    print(f'RAM Used         : {ram_total} bytes')
    print(f'RAM Remaining    : {ram_remaining} bytes')
    print(f'RAM Usage        : {ram_percent:.2f}%')

    print('\n------ Section Breakdown ------')

    for section, size in sorted(section_sizes.items()):
        print(f'{section:<15} {size:>6} bytes')


if __name__ == '__main__':
    main()
