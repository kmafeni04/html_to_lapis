function toClipboard() {
  // Get the text
  var copyText = document.getElementById("result");

  navigator.clipboard.writeText(copyText.innerHTML);

  // Alert the copied text
  alert("Copied to clipboard");
} 
