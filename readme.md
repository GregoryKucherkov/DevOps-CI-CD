1. To start project, we need to make sure we got Django. In order to do that, use the following command:

(for macOS)
bash instal_env.sh

2. then, activate venv:
   source env/bin/activate

3. To compose docker container use:
   docker-compose up -d

4. After that, we need to run migrations(otherwise we will get a error), use:
   docker-compose run django python manage.py migrate

To check logs use:
docker-compose logs django

To create a superuser:
docker-compose run django python manage.py createsuperuser

Now we have Djungo running on :8000 and :80 via nginx.
