# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.0-base

# install custom nodes into comfyui
# 更新 ComfyUI 到最新版本（强烈推荐，确保支持 Z-Image Turbo 的最新修复）
RUN comfy update
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5
RUN comfy node install --exit-on-fail comfys3@1.0.1
# 可选：如果想用 GGUF 量化版 Qwen（更省 VRAM、更快加载），加这一行
# RUN comfy node install --exit-on-fail city96/ComfyUI-GGUF

# download models into comfyui
RUN comfy model download --url https://huggingface.co/tarn59/pixel_art_style_lora_z_image_turbo/resolve/main/pixel_art_style_z_image_turbo.safetensors --relative-path models/loras --filename pixel_art_style_z_image_turbo.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors --relative-path models/diffusion_models --filename z_image_turbo_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors --relative-path models/text_encoders --filename qwen_3_4b.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors --relative-path models/vae --filename ae.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
