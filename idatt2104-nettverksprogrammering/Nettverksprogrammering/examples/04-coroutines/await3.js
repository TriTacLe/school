// Async and await

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

await sleep(5000);
console.log('After 5 seconds');
await sleep(5000);
console.log('After 10 seconds');
