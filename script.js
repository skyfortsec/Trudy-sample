const yearEl = document.getElementById("year");
yearEl.textContent = new Date().getFullYear();

const copyBtn = document.getElementById("copyBtn");
const welcomeText = document.getElementById("welcomeText");
const hint = document.getElementById("hint");

copyBtn.addEventListener("click", async () => {
  const text =
    welcomeText.value.trim() ||
    "Welcome Trudy to Cloud4Future. A Little Progress everyday adds up to Big Result.";

  try {
    await navigator.clipboard.writeText(text);
    hint.textContent = "Copied! ✅ Paste it anywhere (email, WhatsApp, LinkedIn).";
    setTimeout(() => (hint.textContent = ""), 2500);
  } catch {
    hint.textContent = "Could not auto-copy. Please select the text and copy manually.";
  }
});
