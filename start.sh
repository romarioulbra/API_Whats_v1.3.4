# #!/bin/sh

# if [ "$DOCKER_ENV" = "true" ];
# then
#   echo "Enabling environment variables for Docker"
#   echo "DOCKER_ENV=$DOCKER_ENV"
#   echo
# fi
# echo "> removing dist"
# rm -rf ./dist
# echo
# echo "> transpiling..."
# npm run build

# echo
# echo "> Successfully build "

# echo
# echo "> Starting application..."
# echo

# node ./dist/src/main.js

#!/bin/sh

if [ "$DOCKER_ENV" = "true" ];
then
  echo "Enabling environment variables for Docker"
  echo "DOCKER_ENV=$DOCKER_ENV"
  echo
fi

echo "⏳ Aguardando banco de dados responder..."
until nc -z "$DATABASE_HOST" 5432; do
  sleep 1
done

echo "✅ Banco de dados disponível!"

echo
echo "> Removing dist"
rm -rf ./dist

echo
echo "> Transpiling..."
npm run build

echo
echo "📦 Rodando migrações Prisma..."
npx prisma migrate deploy

echo
echo "🚀 Iniciando aplicação..."
node ./dist/src/main.js
