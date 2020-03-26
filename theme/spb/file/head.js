export default {
  title: 'Supplz Theme',
  titleTemplate: '%s - Питер',
  htmlAttrs: {
    lang: 'ru'
  },
  meta: [
    { charset: 'utf-8' },
    { vmid: 'description', name: 'description', content: 'Интернет-магазин Supplz - продажа одноразовой посуды, пищевой упаковки, товаров для кафе, ресторанов и офисов. ' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1, minimal-ui' },
    { name: 'robots', content: 'index, follow' },
    { name: 'mobile-web-app-capable', content: 'yes' },
    { name: 'theme-color', content: '#ffffff' },
    { name: 'apple-mobile-web-app-status-bar-style', content: '#ffffff' }
  ],
  link: [
    { rel: 'icon', type: 'image/png', href: '/assets/favicon-32x32.png', sizes: '32x32' },
    { rel: 'icon', type: 'image/png', href: '/assets/favicon-16x16.png', sizes: '16x16' },
    { rel: 'manifest', href: '/assets/manifest.json' },
    { rel: 'stylesheet', as: 'style', href: 'https://fonts.googleapis.com/css?family=Playfair+Display:400,700|Roboto:400,700|Material+Icons&display=swap' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com/', crossorigin: 'anonymous' }
  ],
  script: [
    {
      src: 'https://cdn.jsdelivr.net/npm/pwacompat@2.0.6/pwacompat.min.js',
      async: true,
      integrity: 'sha384-GOaSLecPIMCJksN83HLuYf9FToOiQ2Df0+0ntv7ey8zjUHESXhthwvq9hXAZTifA',
      crossorigin: 'anonymous'
    }
  ],
  noscript: [
    { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Playfair+Display:400,700|Roboto:400,700|Material+Icons&display=swap' }
  ]
};
