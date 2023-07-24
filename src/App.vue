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
          v-show="$vuetify.breakpoint.smAndDown"
          centered
          class="ml-n9"
          color="grey darken-1"
      >
        <v-tab
            v-for="(link, index) in links"
            :key="index"
            @click="scrollToColumn(index)"
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
      <div class="text-center">
        <v-dialog
            v-model="dialog"
            width="500"
            overlay-opacity="0.9"
            :persistent="true"
        >

          <v-card>
            <v-card-title class="text-h5 pink lighten-2 white--text">
              Create individual timetable
            </v-card-title>
              <ErstiFilter :ukrainian="ukrainian"
                           :flinta="flinta"
                           :international="international"
                           :selected_degree="selected_degree"
                           :selected_course="selected_course"
                           :courses-dict="coursesDict"
                           @update:selectedDegree="selectDegree"
                           @update:selectedCourse="selectCourse"
                           @update:ukrainian="toggleUkrainian"
                           @update:flinta="toggleFlinta"
                           @update:international="toggleInternational">

              </ErstiFilter>
            <v-divider></v-divider>
            <v-card-actions>
              <v-btn
                  color="pink"
                  text
                  @click="closeDialogAndScrollToCalendar"
              >
                Show my timetable
              </v-btn>
<!--              <v-btn-->
<!--                  color="grey accent-4"-->
<!--                  text-->
<!--                  @click="showAllAndClose"-->
<!--              >-->
<!--                Show all events-->
<!--              </v-btn>-->
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
      <v-container>
        <v-row>
          <v-col
              ref="filterCol"
              cols="12"
              sm="2"
          >
            <v-card
                rounded="lg"
                min-height="50"
            >

              <v-card-text
              >
                <ErstiFilter

                    :disabled="this.all"
                    :ukrainian="ukrainian"
                    :flinta="flinta"
                    :international="international"
                    :selected_degree="selected_degree"
                    :selected_course="selected_course"
                    :courses-dict="coursesDict"
                    @update:selectedDegree="selectDegree"
                    @update:selectedCourse="selectCourse"
                    @update:ukrainian="toggleUkrainian"
                    @update:flinta="toggleFlinta"
                    @update:international="toggleInternational"
                ></ErstiFilter>
              </v-card-text>

              <v-spacer></v-spacer>
              <v-card-actions>
                <v-btn
                    text
                    :color="this.all ? 'primary' : 'grey accent-4'"
                    @click="handleClick"
                >
                  {{ this.all ? 'Create Individual Timetable' : 'Show All Events' }}
                </v-btn>
              </v-card-actions>

              <!--  -->
            </v-card>

          </v-col>

          <v-col
              ref="calendarCol"
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
                  :all="all"
              ></ErstiCalendar>
            </v-sheet>
          </v-col>

          <v-col
              ref="infoCol"
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
    scrollToColumn(index) {
      let ref;
      switch(index) {
        case 0:
          ref = 'filterCol';
          break;
        case 1:
          ref = 'calendarCol';
          break;
        case 2:
          ref = 'infoCol';
          break;
      }
      this.$nextTick(() => {
        this.$refs[ref].scrollIntoView({ behavior: 'smooth' });
      });
    },
    closeDialogAndScrollToCalendar() {
      this.dialog = false;
      this.$nextTick(() => {
        this.$refs.calendarCol.scrollIntoView({ behavior: 'smooth' });
      });
    },
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
    },
    handleClick() {
      this.reveal = true;
      this.toggleAll();
      this.selected_degree = null;
      this.selected_course = null;
    },
    showAllAndClose(){
      this.all = true;
      this.dialog = false;
    },
    toggleAll() {
      this.all = !this.all;
    }

  },
  data: () => ({
    international: false,
    ukrainian: false,
    flinta: true,
    selected_degree: null,
    selected_course: null,
    coursesDict,
    dialog: true,
    all: false,
    links: [
      'Filter',
      'Calendar',
      'Additional Information'
    ],
  }),
}
</script>