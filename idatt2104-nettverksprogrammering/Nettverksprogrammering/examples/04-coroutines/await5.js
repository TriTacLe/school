// Promises only

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

sleep(5000)
  .then(() => {
    console.log('After 5 seconds');
    return sleep(5000);
  })
  .then(() => {
    console.log('After 10 seconds');
  });
