<template>
  <div>
    <div class="product-quantity" v-if="qtyVisible">
      <base-input-number
        :value="qty"
        :min="0"
        :max="max"
        :step="step"
        :disabled="qtyDisabled"
        v-on:change.native="modifyItemQty"
      />
    </div>
    <div class="id-cart" v-if="!qtyVisible">
      <button
        type="button"
        class="relative bg-cl-transparent brdr-none inline-flex"
        @click="addProductItem"
        :aria-label="$t('Add to cart')"
      >
        <i class="material-icons">shopping_cart</i>
      </button>
    </div>
  </div>
</template>

<script>
  import BaseInputNumber from 'theme/components/core/blocks/Form/BaseInputNumber'
  import {mapGetters} from "vuex";
  import {notifications} from "@vue-storefront/core/modules/cart/helpers";

  export default {
    props: {
      product: {
        type: [Object],
        required: true
      }
    },
    components: {
      BaseInputNumber
    },
    data() {
      return {
        qtyVisible: false,
        qtyDisabled: false,
        value: 0,
        max: undefined,
        step: 1
      }
    },
    computed: {
      ...mapGetters({
        productsInCart: 'cart/getCartItems'
      }),
      cartItemForProduct() {
        let result;
        const sku = this.product.sku;
        for (const item of this.productsInCart) {
          if (sku === item.sku) {
            result = item;
            break;
          }
        }
        return result;
      },
      qty() {
        let result = this.step;
        const item = this.cartItemForProduct;
        if (item && item.qty) {
          result = item.qty;
        }
        return result;
      }
    },
    methods: {
      notifyUser(notificationData) {
        this.$store.dispatch('notification/spawnNotification', notificationData, {root: true});
      },
      async addProductItem() {
        /* add product to the cart first time */
        this.qtyVisible = !this.qtyVisible;
        try {
          this.qtyDisabled = true;
          this.product.qty = this.step;
          const diffLog = await this.$store.dispatch('cart/addItem', {productToAdd: this.product});
          this.qtyDisabled = false;
          diffLog.clientNotifications.forEach(notificationData => {
            this.notifyUser(notificationData)
          })
        } catch (message) {
          this.notifyUser(notifications.createNotification({type: 'error', message}))
        }
      },
      async modifyItemQty(event) {
        const value = event.target.valueAsNumber;
        const product = this.cartItemForProduct;
        this.qtyDisabled = true;
        if (value <= 0) {
          /* remove cart item */
          this.qtyVisible = false;
          const diffLog = await this.$store.dispatch('cart/removeItem', {product});
          diffLog.clientNotifications.forEach(notificationData => {
            this.notifyUser(notificationData)
          })
        } else {
          /* modify qty for the cart item */
          try {
            const diffLog = await this.$store.dispatch('cart/updateQuantity', {product, qty: value});
            diffLog.clientNotifications.forEach(notificationData => {
              this.notifyUser(notificationData)
            })
          } catch (message) {
            this.notifyUser(notifications.createNotification({type: 'error', message}))
          }
        }
        this.qtyDisabled = false;
      }
    },
    beforeMount() {
      /* set max & step for qty */
      const stock = this.product.stock;
      if (stock) {
        this.max = stock.qty;
        this.step = stock.qty_increments ?? 1;
      }
      /* modify qty value according to the shopping cart and switch visibility for "qty_input"/"cart_icon" */
      const item = this.cartItemForProduct;
      if (item) {
        this.qtyVisible = true;
      }
    }
  }
</script>
