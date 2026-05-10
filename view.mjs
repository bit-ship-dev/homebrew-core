#!/usr/bin/env node

import crypto from 'crypto';

const packageName = 'bit-ship';

async function calculateSHA256(url) {
  const response = await fetch(url);
  const buffer = await response.arrayBuffer();
  const hash = crypto.createHash('sha256');
  hash.update(Buffer.from(buffer));
  return hash.digest('hex');
}

async function fetchPackageInfo() {
  try {
    const response = await fetch(`https://registry.npmjs.org/${packageName}`);

    if (!response.ok) {
      throw new Error(`Failed to fetch package info: ${response.statusText}`);
    }

    const data = await response.json();

    // Nightly version
    const nightlyVersion = data['dist-tags'].nightly;
    const nightlyData = data.versions[nightlyVersion];

    console.log('=== NIGHTLY ===');
    console.log(`Package: ${packageName}`);
    console.log(`Version: ${nightlyVersion}`);
    console.log(`Tarball URL: ${nightlyData.dist.tarball}`);
    console.log(`SHA-512: ${nightlyData.dist.integrity || 'N/A'}`);
    console.log(`SHA-1 (shasum): ${nightlyData.dist.shasum}`);
    const nightlySHA256 = await calculateSHA256(nightlyData.dist.tarball);
    console.log(`SHA-256: ${nightlySHA256}`);

    console.log('\n=== LATEST ===');
    // Latest version
    const latestVersion = data['dist-tags'].latest;
    const latestData = data.versions[latestVersion];

    console.log(`Package: ${packageName}`);
    console.log(`Version: ${latestVersion}`);
    console.log(`Tarball URL: ${latestData.dist.tarball}`);
    console.log(`SHA-512: ${latestData.dist.integrity || 'N/A'}`);
    console.log(`SHA-1 (shasum): ${latestData.dist.shasum}`);
    const latestSHA256 = await calculateSHA256(latestData.dist.tarball);
    console.log(`SHA-256: ${latestSHA256}`);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

fetchPackageInfo();
