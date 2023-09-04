document.addEventListener('turbo:load', () => {
  const generateQRCodeButton = document.getElementById('generate_qrcode_button');
  const qrcodeImage = document.getElementById('qrcode_image');

  if (generateQRCodeButton) {
    generateQRCodeButton.addEventListener('ajax:success', (event) => {
      const response = event.detail[0];

      // Update the QR code image source
      qrcodeImage.src = response.qr_code_url;
    });
  }
});
