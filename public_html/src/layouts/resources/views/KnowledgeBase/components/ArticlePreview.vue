<!--
/**
 * ArticlePreview component
 *
 * @description Article preview parent component
 * @license YetiForce Public License 3.0
 * @author Tomasz Poradzewski <t.poradzewski@yetiforce.com>
 */
-->
<template>
  <q-dialog
    v-model="dialog"
    :maximized="maximizedOnly ? true : previewMaximized"
    transition-show="slide-up"
    transition-hide="slide-down"
    content-class="quasar-reset"
  >
    <drag-resize v-if="isDragResize" :coordinates.sync="coordinates" :maximized="previewMaximized">
      <article-preview-content :height="coordinates.height" :previewMaximized.sync="previewMaximized" />
    </drag-resize>
    <article-preview-content v-else>
      <template slot="header-right">
        <slot name="header-right"></slot>
      </template>
    </article-preview-content>
  </q-dialog>
</template>
<script>
import DragResize from 'components/DragResize.vue'
import ArticlePreviewContent from './ArticlePreviewContent.vue'
import { createNamespacedHelpers } from 'vuex'
const { mapGetters } = createNamespacedHelpers('KnowledgeBase')
export default {
  name: 'ArticlePreview',
  components: { ArticlePreviewContent, DragResize },
  props: {
    isDragResize: {
      type: Boolean,
      default: true
    },
    maximizedOnly: {
      type: Boolean,
      default: false
    },
    previewDialog: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      coordinates: {
        width: Quasar.plugins.Screen.width - 100,
        height: Quasar.plugins.Screen.height - 100,
        top: 0,
        left: Quasar.plugins.Screen.width - (Quasar.plugins.Screen.width - 100 / 2)
      },
      previewMaximized: true
    }
  },
  computed: {
    dialog: {
      get() {
        return this.previewDialog
      },
      set(val) {
        this.$emit('update:previewDialog', val)
      }
    }
  }
}
</script>
<style>
</style>
