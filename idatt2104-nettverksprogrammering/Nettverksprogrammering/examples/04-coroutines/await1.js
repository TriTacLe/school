// Callbacks

setTimeout(() => {
  console.log('After 5 seconds');
  setTimeout(() => {
    console.log('After 10 seconds');
  }, 5000);
}, 5000);
