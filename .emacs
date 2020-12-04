(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   (quote
    ("973c3250a04a34d7f4f7db2576d19f333ecd6b59ab40c2b9772b007d486b6ab0" default)))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (smooth-scrolling flycheck ample-theme vs-dark-theme org-plus-contrib writeroom-mode olivetti markdown-mode evil)))
 '(writeroom-border-width 50)
 '(writeroom-fringes-outside-margins nil)
 '(writeroom-global-effects
   (quote
    (writeroom-set-fullscreen writeroom-set-alpha writeroom-set-menu-bar-lines writeroom-set-tool-bar-lines writeroom-set-vertical-scroll-bars writeroom-set-internal-border-width))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "BE5N" :slant normal :weight normal :height 132 :width normal))))
 '(markdown-code-face ((t nil)))
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face)))))

(require 'evil)
(evil-mode 1)

(load-theme 'ample t t)
(enable-theme 'ample)

(setq make-backup-files nil)

(setq-default completion-ignore-case t)
(setq-default read-file-name-completion-ignore-case t)
(setq-default read-buffer-completion-ignore-case t)
(setq tab-width 2) 
(setq-default tab-width 2)
(setq-default evil-shift-width 2)
(setq-default indent-tabs-mode nil)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(evil-ex-define-cmd "q" 'kill-this-buffer)


(add-hook 'writeroom-mode-hook
  (lambda ()
    (if writeroom-mode
      (progn
        (fringe-mode 0))  ; hide fringes
      (progn
        (fringe-mode nil)))))

(defun helvetica-face-set ()
   (interactive)
   (setq buffer-face-mode-face '(:family "Helvetica Neue"))
   (buffer-face-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode)
            (flyspell-mode)))

(global-set-key (kbd "<f12>") 'writeroom-mode)   ; open writeroom-mode

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd "z g") 'flyspell-correct-word-before-point)
  (define-key evil-normal-state-map (kbd "C-v") 'evil-visual-block))

(electric-pair-mode 1)

(require 'ido)
(ido-mode t)

(setq-default flycheck-display-errors-delay 0)

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 3)

(set-frame-font "Iosevka 13" nil t)
