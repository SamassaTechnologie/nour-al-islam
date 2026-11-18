import { mkdir, writeFile } from "node:fs/promises";
import sharp from "sharp";

const art = (scale) => {
  const offset = (512 - 512 * scale) / 2;
  return `<g transform="translate(${offset} ${offset}) scale(${scale})">
    <path d="M120 430V238C120 178 206 140 256 76c50 64 136 102 136 162v192Z" fill="#ffffff" stroke="#c9a85a" stroke-width="10"/>
    <path fill="#0a6b50" d="M256 214l21 21h30v30l21 21-21 21v30h-30l-21 21-21-21h-30v-30l-21-21 21-21v-30h30Z"/>
  </g>`;
};
const svg = (scale, radius = 0) =>
  `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><rect width="512" height="512" rx="${radius}" fill="#06382c"/>${art(scale)}</svg>`;

await mkdir("public/icons", { recursive: true });
await writeFile("public/favicon.svg", svg(1, 96));
const render = (source, size, file) => sharp(Buffer.from(source)).resize(size, size).png().toFile(`public/icons/${file}`);
await render(svg(1), 192, "icon-192.png");
await render(svg(1), 512, "icon-512.png");
await render(svg(0.78), 512, "icon-maskable-512.png");
await render(svg(1), 180, "apple-touch-icon.png");
