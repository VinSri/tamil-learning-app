// Tamil TTS
// Strategy: use Web Speech API only if a ta-IN voice is available.
// Otherwise fall back to the server-side Google Translate proxy (always Tamil).

function extractTamil(text) {
  const cleaned = text
    .split('|')[0]
    .replace(/\(.*?\)/g, '')
    .replace(/[a-zA-Z0-9.,!?:;\/\-–—]/g, '')
    .replace(/\s+/g, ' ')
    .trim();

  // Single bare consonant like க் — strip pulli so it sounds like "ka"
  if (/^[\u0B95-\u0BB9]\u0BCD$/.test(cleaned)) {
    return cleaned.replace('\u0BCD', '');
  }
  return cleaned;
}

function getTamilVoice() {
  if (!window.speechSynthesis) return null;
  return window.speechSynthesis.getVoices()
    .find(v => v.lang === 'ta-IN' || v.lang === 'ta' || v.lang.startsWith('ta-'));
}

function speakViaProxy(text) {
  const audio = new Audio(`/audio/tts?text=${encodeURIComponent(text)}`);
  audio.play().catch(() => {});
}

function speak(rawText) {
  const text = extractTamil(rawText);
  if (!text) return;

  const tamilVoice = getTamilVoice();

  if (tamilVoice) {
    window.speechSynthesis.cancel();
    const utter = new SpeechSynthesisUtterance(text);
    utter.lang   = 'ta-IN';
    utter.voice  = tamilVoice;
    utter.rate   = 0.85;
    window.speechSynthesis.speak(utter);
  } else {
    speakViaProxy(text);
  }
}

// Preload voices on page load (Chrome loads them async)
if (window.speechSynthesis) {
  window.speechSynthesis.getVoices();
  window.speechSynthesis.onvoiceschanged = () => window.speechSynthesis.getVoices();
}

window.speak = speak;
