# ขั้นตอนที่ 1: สร้าง build
FROM node:18-alpine AS build

# กำหนด working directory
WORKDIR /app

# คัดลอกไฟล์ไปยัง container
COPY package.json package-lock.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกโค้ดทั้งหมด
COPY . .

# สร้างโปรเจกต์
RUN npm run build

# ขั้นตอนที่ 2: รัน production server
FROM nginx:alpine

# คัดลอกไฟล์ build ไปยัง nginx public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# เริ่ม nginx server
CMD ["nginx", "-g", "daemon off;"]
