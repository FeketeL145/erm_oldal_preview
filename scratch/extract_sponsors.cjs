const fs = require('fs');
const html = fs.readFileSync('scratch/old_site.html', 'utf8');

// Find section with id="clients" or sponsors
const clientIdx = html.indexOf('id="clients"');
console.log('Client section index:', clientIdx);

if (clientIdx !== -1) {
  const section = html.substring(clientIdx, clientIdx + 50000);
  // Match all <a> tags with <img> inside
  const regex = /<a[^>]+href=["']([^"']+)["'][^>]*>[\s\S]*?<img[^>]+src=["']([^"']+)["'][^>]*alt=["']?([^"'>]*)["']?[^>]*>[\s\S]*?<\/a>/gi;
  let m;
  const links = [];
  while ((m = regex.exec(section)) !== null) {
    links.push({ url: m[1], logo: m[2], alt: m[3] });
  }
  console.log(`Found ${links.length} sponsor links in #clients section.`);
  fs.writeFileSync('scratch/scraped_sponsors.json', JSON.stringify(links, null, 2));
  console.log('Sample:', links.slice(0, 10));
} else {
  // Let's search for all href containing http or sponsor logos
  const regex = /<a[^>]+href=["']([^"']+)["'][^>]*>[\s\S]*?<img[^>]+src=["']([^"']*(?:sponsor|client)[^"']*)["'][^>]*>/gi;
  let m;
  const links = [];
  while ((m = regex.exec(html)) !== null) {
    links.push({ url: m[1], logo: m[2] });
  }
  console.log(`Found ${links.length} matches across document.`);
}
