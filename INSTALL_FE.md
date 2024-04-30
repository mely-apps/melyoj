# Hướng dẫn build source MelyOJ (Frontend)

# Video Hướng dẫn

[![Watch the video](https://github.com/mely-apps/melyoj/assets/59696851/8304a7d2-c7ee-415c-8129-dd4381de1f37)](https://drive.google.com/file/d/1k2N0sdQNyJvuCdcT4p6871422Or2xt6o/view?usp=sharing)

## Môi trường build được sử dụng trong hướng dẫn: Ubuntu 23.04, ARM64. Khuyến khích sử dụng các distro dựa trên Debian (Ubuntu, Linux Mint, etc..)

# Cài đặt package cần thiết

Mở terminal và thực hiện các câu lệnh sau

```bash
$ sudo apt update
$ sudo apt install git gcc g++ make wget curl python3-dev python3-pip python3-venv libxml2-dev libxslt1-dev zlib1g-dev gettext curl redis-server build-essential mariadb-server libmysqlclient-dev
$ curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
$ sudo apt install nodejs
$ sudo npm i -g yarn
$ sudo yarn add -g sass postcss-cli postcss autoprefixer tailwindcss
```

# Cấu hình database

Mở MariaDB đã được cài đặt trong phần trước, sau đó cấu hình theo hướng dẫn

```bash
$ mariadb
MariaDB [(none)]> CREATE DATABASE melyoj DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
MariaDB [(none)]> GRANT ALL PRIVILEGES ON melyoj.* TO 'melyoj'@'localhost' IDENTIFIED BY '<mariadb user password>';
MariaDB [(none)]> exit
$ mariadb-tzinfo-to-sql /usr/share/zoneinfo | sudo mariadb -u root mysql
```

# Chuẩn bị source

Tạo môi trường ảo (có thể dùng Anaconda để thay thế)

```bash
$ python3 -m venv melyojsite
$ source ~/melyojsite/bin/activate
```

Tải source code

```bash
$ git clone git@github.com:mely-apps/melyoj.git
$ cd melyoj
$ git submodule init
$ git submodule update

```

Cài đặt dependencies

```bash
$ pip3 install -r requirements.txt
$ pip3 install lxml_html_clean
$ yarn
```

Cấu hình MelyOJ

Tải file settings sample của DMOJ, config theo nhu cầu cá nhân

```bash
$ cd dmoj
$ wget https://raw.githubusercontent.com/DMOJ/docs/master/sample_files/local_settings.py
$ nano local_settings.py # Có thể dùng text editor khác
```

Kiểm tra cấu hình

```bash
$ python3 ../manage.py check
```

# Compile CSS

```bash
$ cd ..
$ ./make_style.sh && echo yes | python3 manage.py collectstatic
$ python3 manage.py compilemessages
$ python3 manage.py compilejsi18n
```

# Migrate database schema

```bash
$ python3 manage.py makemigrations
$ python3 manage.py migrate
```

Load một số dữ liệu sample:

```bash
$ python3 manage.py loaddata navbar
$ python3 manage.py loaddata language_small
$ python3 manage.py loaddata demo
```

# Chạy server development

```bash
$ python3 manage.py runserver 0.0.0.0:8000
```

Truy cập web dev tại localhost:8000

Quy trình dev:

- Thực hiện các thay đổi CSS trong `resources/`, các thay đổi HTML trong `templates/`
- Sau khi hoàn thành các thay đổi CSS, cần compile lại CSS theo hướng dẫn sau
  ```bash
  $ yarn dev:fe
  ```
- Thực hiện F5 (hoặc Ctrl-F5) để thấy thay đổi mới của trang

# Good luck ;)
