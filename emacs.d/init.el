(defmacro on-linux (&rest body)
  (when (string-match "linux" (prin1-to-string system-type))
    `(progn ,@body)))

(defmacro on-windows (&rest body)
  (when (string-match "windows" (prin1-to-string system-type))
    `(progn ,@body)))

(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq current-language-environment "Bulgarian")
(setq default-input-method "bulgarian-phonetic")
(setq load-path
      (append load-path
              '("~/.emacs.d/lisp"
                "~/.emacs.d/progmodes"
                "~/.emacs.d/color-theme-6.6.0")))

;; remove big yellow exclamation mark
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; (require 'yasnippet)
;; (yas/global-mode 1)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'global-font-lock-mode)
(global-set-key (kbd "C-.") 'my-increase-left-margin)
(global-set-key (kbd "C-,") 'my-decrease-left-margin)
(global-set-key [C-tab] 'bs-cycle-next)
(global-set-key [C-S-tab] 'bs-cycle-previous))

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(global-set-key (kbd "<f11>") 'toggle-fullscreen)

(defun expand-region-to-whole-lines ()
  "Expand the region to make it encompass whole lines.
If the region is not active, activate the current line."
  (if (not mark-active)
      ;; Create region from current line
      (progn
        (beginning-of-line)
        (set-mark (point))
        (end-of-line))
    ;; The mark is active, expand region
    (let ((beg (region-beginning))
          (end (region-end)))
      (goto-char beg)
      (beginning-of-line)
      (set-mark (point))
      (goto-char end)
      (unless (bolp) (end-of-line)))))

(defun my-increase-left-margin ()
  "Increase left margin in region after expanding it to whole lines."
  (interactive)
  (let (deactivate-mark)
    (expand-region-to-whole-lines)
    (increase-left-margin (region-beginning) (region-end) nil)))

(defun my-decrease-left-margin ()
  "Decrease left margin in region after expanding it to whole lines."
  (interactive)
  (let (deactivate-mark)
    (expand-region-to-whole-lines)
    (decrease-left-margin (region-beginning) (region-end) nil)))


(defun setup-frame (frame)
  (require 'maxframe)
  (select-frame frame)
  (on-linux (set-frame-parameter frame 'font-backend '(xft x))
            (set-frame-font "Inconsolata 17")) ; "Bitstream Vera Sans Mono 15"
  (on-windows (set-frame-font "-*-Consolas-normal-r-*-*-22-*-*-*-c-*-*-iso8859-1"))
  (maximize-frame))


(add-hook 'after-make-frame-functions 'setup-frame)
(add-hook 'window-setup-hook (lambda () (setup-frame (selected-frame))))

(ido-mode 1)
(show-paren-mode 1)
(which-func-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(transient-mark-mode 1)
(dynamic-completion-mode 1)
(auto-compression-mode 1)
(global-font-lock-mode 1)
(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
(setq tab-always-indent 'complete)
(setq visible-bell t)
(setq bell-volume 0)
(setq scroll-step 1)
(setq case-fold-search t)
(setq make-backup-files nil)
(setq mouse-yank-at-point t)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq dired-recursive-deletes 'top)
(setq ido-enable-flex-matching t)
(setq parens-require-spaces nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq default-major-mode 'text-mode)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default ispell-program-name "aspell")

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(global-set-key (kbd "C-c n") 'linum-mode)
(setq linum-format "%d  ")
(global-set-key (kbd "C-c w") 'whitespace-mode)

(require 'pager)
(global-set-key (kbd "C-v") 'pager-page-down)
(global-set-key (kbd "M-v") 'pager-page-up)
(global-set-key (kbd "M-p") 'pager-row-up)
(global-set-key (kbd "M-n") 'pager-row-down)

(require 'redo)
(global-set-key (kbd "C-/") 'undo)
(global-set-key (kbd "C-?") 'redo)

(require 'color-theme)
(color-theme-initialize)

(require 'zenburn)
(color-theme-zenburn)

;; (require 'htmlize)
;; (require 'zencoding-mode)

(autoload 'cg-mode  "cg-mode"  "Cg editing mode." t)
(autoload 'mel-mode "mel-mode" "Mel editting mode." t)
(autoload 'lua-mode "lua-mode" "Lua editting mode." t)
(autoload 'mma-mode "mma.el"   "Mathematica package file mode" t)
(autoload 'rsl-mode "rsl-mode" "RenderMan Shading Language editing mode" t)
(autoload 'rib-mode "rib-mode" "RenderMan Interface Bytestream editing mode" t)
(autoload 'less-css-mode "less-css-mode" "Less CSS editing mode." t)



;; (require 'multi-web-mode)
;;    (setq mweb-default-major-mode 'html-mode)
;;    (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                      (js-mode "<script[^>]*>" "</script>")
;;                      (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                      (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;;    (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;    (multi-web-global-mode 1)

(setq lua-default-application "lua5.1")

(setq auto-mode-alist
      (append '(("\\.cs$"   . c++-mode)
                ("\\.cg$"   . cg-mode)
                ("\\.hlsl$" . cg-mode)
                ("\\.fxh?$" . cg-mode)
                ("\\.sl$"   . rsl-mode)
                ("\\.rib$"  . rib-mode)
                ("\\.ma$"   . mel-mode)
                ("\\.mel$"  . mel-mode)
                ("\\.lua$"  . lua-mode)
                ("\\.hs$"   . haskell-mode)
                ("\\.lhs$"  . literate-haskell-mode)
                ("\\.m$"    . mma-mode)
                ("\\.org$"  . org-mode)
                ("\\.less$"  . less-css-mode)
                ("\\.js$"  . js-mode))
              auto-mode-alist))

;; Switch to *Python* after C-c C-c
(defadvice python-send-buffer
  (after advice-switch-to-python)
  (python-switch-to-python t))

(add-hook
 'shell-mode-hook
 (lambda ()
   (ansi-color-for-comint-mode-on)))

(add-hook
 'c-mode-hook
 (lambda ()
   (c-set-style "linux")
   (setq tab-width 8)
   (setq indent-tabs-mode t)))

(add-hook
 'c++-mode-hook
 (lambda ()
   (setq tab-width 4)
   (c-add-style
    "my-c++-style"
    '((c-basic-offset . 4)
      (c-comment-only-line-offset . 0)
      (c-offsets-alist . ((statement-block-intro . +)
                          (knr-argdecl-intro . +)
                          (substatement-open . 0)
                          (substatement-label . 0)
                          (label . 0)
                          (statement-cont . +)
                          (inline-open . 0)
                          (inexpr-class . 0)
                          (innamespace . 0)
                          (comment-intro . 0)
                          (arglist-intro . +)
                          (arglist-cont . /)
                          (arglist-close . 0)
                          (inher-intro . *)
                          (inher-cont . 0)
                          (member-init-intro . *)
                          (member-init-cont . /)))))
   (c-set-style "my-c++-style")))

(add-hook
 'haskell-mode-hook
 (lambda ()
   (setq tab-width 4)
   (turn-on-haskell-indent)
   (turn-on-haskell-doc-mode)
   (turn-on-haskell-decl-scan)))

(add-hook
 'mel-mode-hook
 (lambda ()
   (require 'etom)
   (setq etom-default-host "localhost")
   (setq etom-default-port 2323)
   (local-set-key (kbd "C-c C-r") 'etom-send-region)
   (local-set-key (kbd "C-c C-c") 'etom-send-buffer)
   (local-set-key (kbd "C-c C-l") 'etom-send-buffer)
   (local-set-key (kbd "C-c C-z") 'etom-show-buffer)))

(add-hook
 'lua-mode-hook
 (lambda ()
   (setq lua-indent-level 4)))

(add-hook
 'sgml-mode-hook
 'zencoding-mode) 

(setq css-indent-offset 2)
(setq js-indent-level 2)

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(elpy
    flycheck))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; Load elpy
(elpy-enable)
;; (define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; (define-key global-map (kbd "C-c o") 'iedit-mode)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "python3")
(on-windows (setq elpy-rpc-python-command "pythonw"))
(on-windows (setq python-shell-completion-native-enable nil))



;; Load markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "gfm-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Load web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; Load vue mode
(require 'use-package)
(require 'lsp-mode)

;; for completions
(use-package company-lsp
  :after lsp-mode
  :config (push 'company-lsp company-backends))

(use-package lsp-mode
  :custom
  (lsp-vetur-format-default-formatter-css "none")
  (lsp-vetur-format-default-formatter-html "none")
  (lsp-vetur-format-default-formatter-js "none")
  (lsp-vetur-validation-template nil))

(use-package vue-mode
  :mode "\\.vue\\'"
  :hook (vue-mode . prettier-js-mode)
  :config
  (add-hook 'vue-mode-hook #'lsp)
  (setq prettier-js-args '("--parser vue")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(elpy-rpc-timeout 2)
 '(package-selected-packages
   (quote
    (company-lsp vue-mode lsp-mode pylint web-mode flycheck markdown-mode jedi iedit elpy)))
 '(python-shell-completion-native-enable nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (autoload 'jedi:setup "jedi" nil t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

(message "init.el loaded successfully.")
