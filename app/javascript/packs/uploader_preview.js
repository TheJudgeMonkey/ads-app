let preview = document.getElementById('preview');
let file_input = document.getElementById('advertisement_files')
file_input.addEventListener("change", previewFiles)

function previewFiles() {
  let files = file_input.files;

  while (preview.firstChild) preview.removeChild(preview.firstChild);

  function readAndPreview(file) {
    if (/\.(jpe?g|png)$/i.test(file.name)) {
      let reader = new FileReader();

      reader.addEventListener("load", function () {
        let image = new Image();
        image.height = 50;
        image.title = file.name;
        image.src = this.result;
        image.id = file.name;
        image.className = "me-1"
        preview.appendChild(image);
      }, false);

      reader.readAsDataURL(file);
    }
  }
  
  if (files) {
    Array.from(files).forEach(file => readAndPreview(file));
  }
}
