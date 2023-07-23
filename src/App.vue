<template>
  <v-app id="inspire">
    <v-app-bar
        app
        color="white"
        flat
    >
      <v-avatar
          :color="$vuetify.breakpoint.smAndDown ? 'grey darken-1' : 'transparent'"
          size="32"
      ></v-avatar>

      <v-tabs
          centered
          class="ml-n9"
          color="grey darken-1"
      >
        <v-tab
            v-for="link in links"
            :key="link"
        >
          {{ link }}
        </v-tab>
      </v-tabs>

      <v-avatar
          class="hidden-sm-and-down"
          color="grey darken-1 shrink"
          size="32"
      ></v-avatar>
    </v-app-bar>

    <v-main class="grey lighten-3">
      <v-container>
        <v-row>
          <v-col
              cols="12"
              sm="2"
          >
            <v-sheet
                rounded="lg"
                min-height="268"
            >
              <ErstiFilter
                  :ukrainian="ukrainian"
                  :flinta="flinta"
                  :international="international"
                  :selected_degree="selected_degree"
                  :courses-dict="coursesDict"
                  @update:selectedDegree="selectDegree"
                  @update:selectedCourse="selectCourse"
                  @update:ukrainian="toggleUkrainian"
                  @update:flinta="toggleFlinta"
                  @update:international="toggleInternational"
              ></ErstiFilter>
              <!--  -->
            </v-sheet>
          </v-col>

          <v-col
              cols="12"
              sm="8"
          >
            <v-sheet
                min-height="70vh"
                rounded="lg"
            >
              <ErstiCalendar
                  :ukrainian="ukrainian"
                  :flinta="flinta"
                  :international="international"
                  :degree="selected_degree"
                  :course="selected_course"
              ></ErstiCalendar>
            </v-sheet>
          </v-col>

          <v-col
              cols="12"
              sm="2"
          >
            <v-sheet
                rounded="lg"
                min-height="268"
            >

              <!--  -->
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import ErstiCalendar from "@/components/Ersti-Calendar.vue";
import ErstiFilter from "@/components/Ersti-Filter.vue";
import coursesDict from "./assets/courses.json"

export default {
  components: {ErstiFilter, ErstiCalendar},
  methods:{
    toggleUkrainian(){
      this.ukrainian = !this.ukrainian;
    },
    toggleFlinta(){
      this.flinta = !this.flinta;
    },
    toggleInternational(){
      this.international = !this.international;
    },
    selectDegree(value){
      this.selected_degree = value;
    },
    selectCourse(value){
      this.selected_course = value;
    }

  },
  data: () => ({
    international: false,
    ukrainian: false,
    flinta: true,
    selected_degree: null,
    selected_course: null,
    coursesDict,
    links: [
      'Dashboard',
      'Messages',
      'Profile',
      'Updates',
    ],
  }),
}
</script>