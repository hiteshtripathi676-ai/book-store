/* =====================================================
   E-BOOK MANAGEMENT SYSTEM - MAIN JAVASCRIPT
   Common Functions and Utilities
   ===================================================== */

// Context path for API calls
const contextPath = document.querySelector('meta[name="context-path"]')?.content || '';

// ===== TOAST NOTIFICATIONS =====
function showToast(message, type = 'success') {
    const toastContainer = document.getElementById('toastContainer') || createToastContainer();
    
    const toastId = 'toast-' + Date.now();
    const iconClass = type === 'success' ? 'fa-check-circle text-success' :
                      type === 'error' ? 'fa-times-circle text-danger' :
                      type === 'warning' ? 'fa-exclamation-circle text-warning' :
                      'fa-info-circle text-info';
    
    const toastHTML = `
        <div id="${toastId}" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas ${iconClass} me-2"></i>
                <strong class="me-auto">${type.charAt(0).toUpperCase() + type.slice(1)}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                ${message}
            </div>
        </div>
    `;
    
    toastContainer.insertAdjacentHTML('beforeend', toastHTML);
    
    const toastElement = document.getElementById(toastId);
    const toast = new bootstrap.Toast(toastElement, { delay: 4000 });
    toast.show();
    
    toastElement.addEventListener('hidden.bs.toast', () => {
        toastElement.remove();
    });
}

function createToastContainer() {
    const container = document.createElement('div');
    container.id = 'toastContainer';
    container.className = 'toast-container position-fixed top-0 end-0 p-3';
    container.style.zIndex = '9999';
    document.body.appendChild(container);
    return container;
}

// ===== LOADING SPINNER =====
function showLoading() {
    const overlay = document.createElement('div');
    overlay.id = 'loadingOverlay';
    overlay.className = 'spinner-overlay';
    overlay.innerHTML = `
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
            <span class="visually-hidden">Loading...</span>
        </div>
    `;
    document.body.appendChild(overlay);
}

function hideLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
        overlay.remove();
    }
}

// ===== CART FUNCTIONS =====
async function addToCart(bookId, quantity = 1) {
    console.log('addToCart called with bookId:', bookId, 'quantity:', quantity);
    console.log('contextPath:', contextPath);
    
    try {
        showLoading();
        console.log('Fetching:', `${contextPath}/cart/add`);
        
        const response = await fetch(`${contextPath}/cart/add`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: `bookId=${bookId}&quantity=${quantity}`
        });
        
        console.log('Response status:', response.status);
        const data = await response.json();
        console.log('Response data:', data);
        hideLoading();
        
        // Handle redirect for login required
        if (data.redirect) {
            showToast(data.message || 'Please login first', 'warning');
            setTimeout(() => {
                window.location.href = data.redirect;
            }, 1500);
            return data;
        }
        
        if (data.success) {
            showToast(data.message, 'success');
            updateCartCount(data.cartCount);
        } else {
            showToast(data.message || 'Failed to add item to cart', 'error');
        }
        
        return data;
    } catch (error) {
        hideLoading();
        console.error('Error adding to cart:', error);
        showToast('An error occurred. Please try again.', 'error');
        return { success: false };
    }
}

async function updateCartQuantity(bookId, quantity) {
    try {
        const response = await fetch(`${contextPath}/cart/update`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: `bookId=${bookId}&quantity=${quantity}`
        });
        
        const data = await response.json();
        
        if (data.success) {
            updateCartTotal(data.cartTotal, data.cartCount);
            showToast('Cart updated', 'success');
        } else {
            showToast(data.message || 'Failed to update cart', 'error');
        }
        
        return data;
    } catch (error) {
        console.error('Error updating cart:', error);
        showToast('An error occurred. Please try again.', 'error');
        return { success: false };
    }
}

async function removeFromCart(bookId) {
    try {
        const response = await fetch(`${contextPath}/cart/remove`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: `bookId=${bookId}`
        });
        
        const data = await response.json();
        
        if (data.success) {
            const itemRow = document.querySelector(`[data-book-id="${bookId}"]`);
            if (itemRow) {
                itemRow.remove();
            }
            updateCartTotal(data.cartTotal, data.cartCount);
            showToast('Item removed from cart', 'success');
            
            // Check if cart is empty
            if (data.cartCount === 0) {
                location.reload();
            }
        } else {
            showToast(data.message || 'Failed to remove item', 'error');
        }
        
        return data;
    } catch (error) {
        console.error('Error removing from cart:', error);
        showToast('An error occurred. Please try again.', 'error');
        return { success: false };
    }
}

function updateCartCount(count) {
    const cartBadge = document.querySelector('.cart-badge');
    if (cartBadge) {
        cartBadge.textContent = count;
        if (count > 0) {
            cartBadge.classList.remove('d-none');
        } else {
            cartBadge.classList.add('d-none');
        }
    }
}

function updateCartTotal(total, count) {
    updateCartCount(count);
    
    const cartTotalElement = document.getElementById('cartTotal');
    if (cartTotalElement) {
        cartTotalElement.textContent = '₹' + total.toFixed(2);
    }
    
    const itemCountElement = document.getElementById('itemCount');
    if (itemCountElement) {
        itemCountElement.textContent = count + ' item(s)';
    }
}

// ===== QUANTITY CONTROLS =====
function initQuantityControls() {
    document.querySelectorAll('.qty-btn-minus').forEach(btn => {
        btn.addEventListener('click', function() {
            const input = this.parentElement.querySelector('.qty-input');
            const currentValue = parseInt(input.value);
            if (currentValue > 1) {
                input.value = currentValue - 1;
                input.dispatchEvent(new Event('change'));
            }
        });
    });
    
    document.querySelectorAll('.qty-btn-plus').forEach(btn => {
        btn.addEventListener('click', function() {
            const input = this.parentElement.querySelector('.qty-input');
            const currentValue = parseInt(input.value);
            const maxValue = parseInt(input.max) || 99;
            if (currentValue < maxValue) {
                input.value = currentValue + 1;
                input.dispatchEvent(new Event('change'));
            }
        });
    });
}

// ===== FORM VALIDATION =====
function initFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });
}

// ===== IMAGE PREVIEW =====
function initImagePreview() {
    const imageInputs = document.querySelectorAll('.image-upload');
    
    imageInputs.forEach(input => {
        input.addEventListener('change', function() {
            const previewId = this.dataset.preview;
            const preview = document.getElementById(previewId);
            
            if (this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    if (preview) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    }
                };
                reader.readAsDataURL(this.files[0]);
            }
        });
    });
}

// ===== SEARCH FUNCTIONALITY =====
function initSearch() {
    const searchForm = document.querySelector('.search-form');
    const searchInput = document.getElementById('searchInput');
    
    if (searchInput) {
        // Debounce search for live search
        let debounceTimer;
        searchInput.addEventListener('input', function() {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(() => {
                if (this.value.length >= 3) {
                    // Trigger search
                    if (searchForm) {
                        searchForm.submit();
                    }
                }
            }, 500);
        });
    }
}

// ===== CONFIRMATION DIALOGS =====
function confirmAction(message) {
    return new Promise((resolve) => {
        if (confirm(message)) {
            resolve(true);
        } else {
            resolve(false);
        }
    });
}

async function confirmDelete(itemName) {
    return await confirmAction(`Are you sure you want to delete "${itemName}"? This action cannot be undone.`);
}

// ===== PRICE FORMATTING =====
function formatPrice(price) {
    return '₹' + parseFloat(price).toFixed(2);
}

// ===== DATE FORMATTING =====
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-IN', options);
}

// ===== SCROLL TO TOP =====
function initScrollToTop() {
    const scrollBtn = document.createElement('button');
    scrollBtn.id = 'scrollToTop';
    scrollBtn.className = 'btn btn-primary position-fixed';
    scrollBtn.style.cssText = 'bottom: 20px; right: 20px; z-index: 1000; display: none; width: 50px; height: 50px; border-radius: 50%;';
    scrollBtn.innerHTML = '<i class="fas fa-arrow-up"></i>';
    document.body.appendChild(scrollBtn);
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            scrollBtn.style.display = 'block';
        } else {
            scrollBtn.style.display = 'none';
        }
    });
    
    scrollBtn.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
}

// ===== LAZY LOADING IMAGES =====
function initLazyLoad() {
    if ('loading' in HTMLImageElement.prototype) {
        const images = document.querySelectorAll('img[loading="lazy"]');
        images.forEach(img => {
            img.src = img.dataset.src || img.src;
        });
    } else {
        // Fallback for browsers that don't support lazy loading
        const script = document.createElement('script');
        script.src = 'https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.3.2/lazysizes.min.js';
        document.body.appendChild(script);
    }
}

// ===== ADMIN SIDEBAR TOGGLE =====
function initAdminSidebar() {
    const sidebarToggle = document.querySelector('.sidebar-toggle');
    const sidebar = document.querySelector('.sidebar');
    const overlay = document.querySelector('.sidebar-overlay');
    
    if (sidebarToggle && sidebar) {
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('show');
            if (overlay) {
                overlay.classList.toggle('show');
            }
        });
        
        if (overlay) {
            overlay.addEventListener('click', function() {
                sidebar.classList.remove('show');
                overlay.classList.remove('show');
            });
        }
    }
}

// ===== PRINT FUNCTION =====
function printElement(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        const printWindow = window.open('', '_blank');
        printWindow.document.write(`
            <html>
                <head>
                    <title>Print</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                </head>
                <body>
                    ${element.innerHTML}
                </body>
            </html>
        `);
        printWindow.document.close();
        printWindow.print();
    }
}

// ===== INITIALIZE ALL FUNCTIONS =====
document.addEventListener('DOMContentLoaded', function() {
    initQuantityControls();
    initFormValidation();
    initImagePreview();
    initSearch();
    initScrollToTop();
    initLazyLoad();
    initAdminSidebar();
    
    // Initialize Bootstrap tooltips
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(tooltipTriggerEl => {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Initialize Bootstrap popovers
    const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]');
    popoverTriggerList.forEach(popoverTriggerEl => {
        new bootstrap.Popover(popoverTriggerEl);
    });
});

// ===== AJAX FORM SUBMISSION =====
async function submitFormAjax(formId, successCallback) {
    const form = document.getElementById(formId);
    if (!form) return;
    
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }
        
        showLoading();
        
        try {
            const formData = new FormData(form);
            const response = await fetch(form.action, {
                method: form.method || 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });
            
            const data = await response.json();
            hideLoading();
            
            if (data.success) {
                showToast(data.message || 'Operation successful', 'success');
                if (successCallback) {
                    successCallback(data);
                }
            } else {
                showToast(data.message || 'Operation failed', 'error');
            }
        } catch (error) {
            hideLoading();
            console.error('Form submission error:', error);
            showToast('An error occurred. Please try again.', 'error');
        }
    });
}

// Export functions for use in other scripts
window.EBookStore = {
    showToast,
    showLoading,
    hideLoading,
    addToCart,
    updateCartQuantity,
    removeFromCart,
    formatPrice,
    formatDate,
    confirmDelete,
    printElement,
    submitFormAjax
};
