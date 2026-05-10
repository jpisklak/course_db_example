// ----- Step 6: checkbox ↔ localStorage wiring -----

const STORAGE_KEY = "selected_items";

// Read selected item IDs
function getSelectedItems() {
  const raw = localStorage.getItem(STORAGE_KEY);
  return raw ? JSON.parse(raw) : [];
}

// Write selected item IDs
function setSelectedItems(items) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(items));
}

// Add or remove one item ID
function toggleItem(itemId, checked) {
  const items = getSelectedItems();

  if (checked && !items.includes(itemId)) {
    items.push(itemId);
  }

  if (!checked) {
    const idx = items.indexOf(itemId);
    if (idx !== -1) items.splice(idx, 1);
  }

  setSelectedItems(items);
}

// Run when the page loads
// document.addEventListener("DOMContentLoaded", () => {
//   const checkbox = document.querySelector("input.include-item");

//   // Not an item page → nothing to do
//   if (!checkbox) return;

//   const itemId = checkbox.dataset.itemId;
//   if (!itemId) return;

//   // Initialize checkbox state
//   const selected = getSelectedItems();
//   checkbox.checked = selected.includes(itemId);

//   // Update storage when user clicks
//   checkbox.addEventListener("change", () => {
//     toggleItem(itemId, checkbox.checked);
//   });
// });

document.addEventListener("DOMContentLoaded", () => {
  const checkboxes = document.querySelectorAll("input.include-item[data-item-id]");
  if (!checkboxes.length) return;

  const selected = getSelectedItems();

  checkboxes.forEach((cb) => {
    const itemId = cb.dataset.itemId;
    cb.checked = selected.includes(itemId);

    cb.addEventListener("change", () => {
      toggleItem(itemId, cb.checked);

      // Keep any other checkboxes for the same item in sync
      document
        .querySelectorAll(`input.include-item[data-item-id="${CSS.escape(itemId)}"]`)
        .forEach((other) => {
          if (other !== cb) other.checked = cb.checked;
        });
    });
  });
});
