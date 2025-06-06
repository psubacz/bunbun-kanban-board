# Build stage
FROM node AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# To deploy on ezhost.dev you need to deploy from a git repo, 
# paste the url of the repo and choose the name you want, 
# when the app is running, go on the expose part, 
# the port is 80 anad choose the subdomain you want 
# after go on https://the_subdomain_you_choose.ezhost-app.com and you will see your kanban board  in 2 min you have your kanban board online :)