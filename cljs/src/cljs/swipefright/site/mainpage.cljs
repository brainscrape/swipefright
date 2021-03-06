(ns swipefright.site.mainpage
  (:require [swipefright.controllers.index :as controllers]
            [reagent.session :as session]
            [clojure.string :as s]
            [accountant.core :as accountant]
            [swipefright.site.landing :as landing]
            [swipefright.site.post :as post]
            [swipefright.site.upload :as upload]))


(defn submit-button []
  [:li 
   [:a.btn.btn-secondary
    {:on-click #(accountant/navigate! "/upload")}
    [:i.fa.fa-cloud-upload.padded-icon]
    "Upload"]])


(defn right-button []
  (fn []
    [:div.navbar-collapse.text-center.collapse.m-5
     [:ul.nav.navbar-nav.ml-auto
      [submit-button]]]))

(defn home-page []
  [:div
   [:nav#topNav.navbar.navbar-expand-sm.navbar-dark
    [:button.navbar-toggler.navbar-toggler-right
     {:type "button", :data-toggle "collapse", :data-target ".navbar-collapse" }
     [:i.fa.fa-bars]]
    [:div.navbar-collapse.collapse.m-5
     [:ul.nav.navbar-nav
      [:li.text-center 
       [:a.btn.btn-secondary
        {:href "#"
         :on-click #(controllers/random-post)} 
        [:i.padded-icon.fa.fa-random]
        "Random"]]]]
    [:a.navbar-brand.mx-auto.w-100.text-center 
     [:img.img-fluid 
      {:on-click #(accountant/navigate! "/")
       :src "/images/sflogov2.svg"}]]
    [right-button]]
   (condp = (session/get :page)
     :jumbotron [landing/jumbotron controllers/random-post]
     :post [post/format-post controllers/random-post]
     :upload [upload/main-page]
     :else nil
     )


   [:footer.footer.text-center
    [:div.container
     [:div.text-muted.footer-text
      "This site should not be viewed by users with a history of heart problems."]]]])
